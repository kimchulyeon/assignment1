
# Mail_Plug_Assignment

## 프로젝트 구조

![image](https://github.com/kimchulyeon/assignment1/assets/86825214/121d9965-2d09-43af-908c-b4e1a54c8335)

## DB - CoreData

사용자의 검색 이력을 CoreData를 사용하여 SAVE / READ / DELETE 하였습니다.

<details>
<summary>코드</summary>

### AppDelegate에서 CoreData "SearchHistory" 컨테이너 생성

```
static var persistentContainer: NSPersistentContainer!

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    AppDelegate.persistentContainer = NSPersistentContainer(name: "SearchHistory")
    AppDelegate.persistentContainer.loadPersistentStores { (description, error) in
        if let error = error {
            fatalError("Failed loading persistent stores: \(error)")
        }
    }

    return true
}
```

### 검색한 텍스트와 선택한 검색 타겟(타입) 저장

predicate를 사용하여 중복된 텍스트 저장 방지

```
 func saveSearchedHistory(searchText: String, searchType: String) {
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "SearchHistory")
    fetchRequest.predicate = NSPredicate(format: "searchText == %@ AND searchType == %@", searchText, searchType)

    do {
        let fetchResults = try context.fetch(fetchRequest)

        // 중복되는 데이터가 없을 경우에만 새로 저장
        if fetchResults.isEmpty {
            let entity = NSEntityDescription.insertNewObject(forEntityName: "SearchHistory", into: context)
            entity.setValue(searchText, forKey: "searchText")
            entity.setValue(searchType, forKey: "searchType")
            try context.save()
        }
    } catch let error {
        print("Failed: \(error)")
    }
}
```

### 저장된 검색 이력 리스트 가져오기

```
func getSearchedHistoryListFromDB() -> [(searchText: String, searchType: String)] {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchHistory")

    var searchHistories: [(searchText: String, searchType: String)] = []

    do {
        let result = try context.fetch(fetchRequest)
        for data in result as! [NSManagedObject] {
            let searchText = data.value(forKey: "searchText") as? String ?? ""
            let searchType = data.value(forKey: "searchType") as? String ?? ""
            searchHistories.append((searchText, searchType))
        }
    } catch let error {
        print("Failed to fetch: \(error)")
    }

    return searchHistories
}
```

### 검색 이력 테이블 리스트 index값과 검색된 텍스트와 선택한 검색 타켓(타입)으로 해당하는 데이터 제거

```
private func deleteSearchedHistory(searchText: String, searchType: String) {
  let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "SearchHistory")
  fetchRequest.predicate = NSPredicate(format: "searchText == %@ AND searchType == %@", searchText, searchType)

  do {
      let result = try context.fetch(fetchRequest)
      for object in result as! [NSManagedObject] {
          context.delete(object)
      }

      try context.save()
    } catch let error {
        print("Failed to delete record: \(error)")
    }
}

func deleteSearchedHistory(at index: Int) {
    let allHistories = getSearchedHistoryListFromDB()
    if index < 0 || index >= allHistories.count {
        print("Invalid index")
        return
    }
    
    let historyToDelete = allHistories[index]
    deleteSearchedHistory(searchText: historyToDelete.searchText, searchType: historyToDelete.searchType)
}
```
</details>

## API - URLSession + Custom URLRequest + Router


URLRequest를 생성할 때 Router(ApiRouter)를 주입해서 URLRequest의 url / httpMethod / headers / queryStrings 을 세팅


<details>
<summary>코드</summary>

### URLRequest + Ext

URLRequest 인스턴스를 생성할 때 ApiRouter를 주입하여 ApiRouter 타입별로 세팅
```
extension URLRequest {
    // 1️⃣ 네트워크 관련 정보를 담고 있는 ApiRouter를 파라미터로 받아서
    init(router: ApiRouter) {
        let base_url = URL(string: router.baseURL)!
        var full_url = base_url.appendingPathComponent(router.path)

        // 2️⃣ URLRequest(url: )를 초기화
        self.init(url: full_url)

        // 3️⃣ URLRequest 네크워크를 설정
        self.httpMethod = router.method

        if let headers = router.header {
            for (key, value) in headers {
                self.setValue(value, forHTTPHeaderField: key)
            }
        }

        // 쿼리스트링 세팅
        if let queryStrings = router.queryString {
            if var components = URLComponents(string: full_url.absoluteString) {
                components.queryItems = queryStrings.map { qs in
                    URLQueryItem(name: qs.key, value: "\(qs.value)")
                }
                
                if let urlWithQS = components.url {
                    full_url = urlWithQS
                    self.url = full_url
                }
            }
        }
    }
}

```

### ApiRouter

URLRequest(router: ApiRouter.board)로 URLSession의 URLRequest 인스턴스를 생성해주면 url / method / path / queryString이 설정된 값으로 생성
```
enum ApiRouter {
    case board
    case post(boardID: Int, offset: Int, limit: Int = 30)
    case search(boardID: Int, searchValue: String?, searchTarget: SearchType.RawValue, offset: Int, limit: Int = 30)

    /// 도메인
    var baseURL: String {
        switch self {
        case .board, .post, .search:
            return Api.BASE_URL
        }
    }
    
    /// GET | POST | DELETE | PUT
    var method: String {
        switch self {
        case .board, .post, .search:
            return "GET"
        }
    }
    
    /// URL PATH
    var path: String {
        switch self {
        case .board:
            return "boards"
        case .post(boardID: let id, offset: _, limit: _):
            return "boards/\(id)/posts"
        case .search(boardID: let id, searchValue: _, searchTarget: _, offset: _, limit: _):
            return "boards/\(id)/posts"
        }
    }
    
    /// Query String
    var queryString: [String: Any]? {
        switch self {
        case .board:
            return nil
        case .post(boardID: _, offset: let offset, limit: let limit):
            return ["offset": offset, "limit": limit]
        case .search(boardID: _, searchValue: let searchValue, searchTarget: let searchTarget, offset: let offset, limit: let limit):
            return ["search": searchValue ?? "", "searchTarget": searchTarget, "offset": offset, "limit": limit]
        }
    }
    
    /// Body
    var body: Data? {
        switch self {
        case .board, .post, .search:
            return nil
        }
    }
    
    /// Header
    var header: [String: String]? {
        switch self {
        case .board, .post, .search:
            return ["Authorization": "Bearer \(Api.KEY)"]
        }
    }
}

```

### 사용 예시

```
let urlRequest = URLRequest(router: ApiRouter.board)
session?.dataTask(with: urlRequest, completionHandler: { [weak self] data, response, error in ... }).resume()
```

## UserDefaultsManager

<details>
<summary>코드</summary>

### 게시판 ID와 게시판 displayName UserDefaults로 관리

```
import Foundation

enum UserDefaultsKeys: String {
    case boardDisplayName
    case boardID
}

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private init() { }
    
    func saveStringData(data: String?, key: UserDefaultsKeys) {
        UserDefaults.standard.set(data, forKey: key.rawValue)
    }
    
    func getStringData(key: UserDefaultsKeys) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
}

```

### 사용 예시

BoardViewModel에서 boardID 프로퍼티가 업데이트될 때마다 저장

```
var boardID: Int? {
    didSet {
        guard let id = boardID else { return }
        UserDefaultsManager.shared.saveStringData(data: id.description, key: .boardID)
        // 나머지 코드
    }
}
```
</details>



</details>
