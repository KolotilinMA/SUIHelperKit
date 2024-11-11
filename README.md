# SwiftUIHelperKit

SwiftUIHelperKit — это библиотека-помощник для Swift

## Установка

### Swift Package Manager

Добавьте SwiftUIHelperKit в ваш проект, используя Swift Package Manager. В Xcode перейдите в:
`File > Add Packages > Вставьте URL-адрес репозитория и выберите версию`

```swift
dependencies: [
    .package(url: "https://github.com/username/SwiftUIHelperKit.git", from: "1.0.0")
]

Использование

Основные функции

Библиотека предоставляет несколько функций weak, которые позволяют безопасно использовать замыкания, ослабляя ссылку на объект. Каждая функция принимает объект и замыкание, выполняемое при наличии объекта.

Примеры использования

	1.	Без параметров:

let object = SomeClass()
let closure = weak(object) { obj in
    obj.someMethod()
}
closure() // вызовет метод, если объект существует


	2.	С одним параметром:

let object = SomeClass()
let closure = weak(object) { obj, param in
    obj.someMethod(param)
}
closure("Пример параметра")


	3.	С двумя параметрами:

let object = SomeClass()
let closure = weak(object) { obj, param1, param2 in
    obj.someMethod(param1, param2)
}
closure("Первый параметр", "Второй параметр")


	4.	С тремя параметрами:

let object = SomeClass()
let closure = weak(object) { obj, param1, param2, param3 in
    obj.someMethod(param1, param2, param3)
}
closure("Первый", "Второй", "Третий")



Преимущества

Использование этих функций помогает предотвратить утечки памяти, так как объект автоматически освобождается из памяти, если он больше не нужен, что делает код более безопасным и чистым.

Пример тестов

Пример тестов для функций weak можно найти в tests/WeakClosureTests.swift.

Требования

	•	iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+
	•	Swift 5.3+

Лицензия

SwiftUIHelperKit распространяется под лицензией MIT. Подробности смотрите в файле LICENSE.

Этот README включает:
- Основные сведения о библиотеке.
- Инструкции по установке.
- Примеры использования с разными типами замыканий.
- Ссылку на тесты и лицензию. 
