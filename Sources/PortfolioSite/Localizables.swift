//
//  File.swift
//  
//
//  Created by Nikolay Truhin on 12/02/23.
//

import Foundation
import Plot

enum LocalizablePhrase {
    case websiteName
    case websiteDescription
    case localeIdentifier
    case untilNow
    case availableOn
    case back
    case page
    case next
    case latestPosts
    case nikolaiTrukhin
    case positionTitle
    case generatedUsing
    case rssChannel
    case chronology
    case otherPosts
    case subscribeTo
    case projects
    case books
    case events
    case career
    case achievements
    case otherTags
    case postsWidth
    case certificate
    case diploma
    case medal
    case app
    case game
    case website
    case chatbot
    case framework
    case office
    case contract
    case remote
    case freelance
    case freeSchedule
    case allPosts
    case listAllPosts
}

extension LocalizablePhrase {
    var russian: String {
        switch self {
        case .websiteName:
            return "Сайт Николая Трухина"
        case .websiteDescription:
            return "Здесь собрана вся информация о моих проектах, мероприятиях что я посетил, книгах что прочитал и многое другое"
        case .localeIdentifier:
            return "ru_RU"
        case .untilNow:
            return " — по настоящее время"
        case .availableOn:
            return "Доступно на"
        case .back:
            return "Назад"
        case .page:
            return "Страница"
        case .next:
            return "Вперед"
        case .latestPosts:
            return "Последние посты"
        case .nikolaiTrukhin:
            return "Николай Трухин"
        case .positionTitle:
            return "iOS разработчик"
        case .generatedUsing:
            return "Сгенерировано с помощью"
        case .rssChannel:
            return "RSS лента"
        case .chronology:
            return "Хронология"
        case .otherPosts:
            return "Остальные посты"
        case .subscribeTo:
            return "Подписаться на"
        case .projects:
            return "Проекты"
        case .books:
            return "Книги"
        case .events:
            return "Мероприятия"
        case .career:
            return "Карьера"
        case .achievements:
            return "Достижения"
        case .otherTags:
            return "Другие теги"
        case .postsWidth:
            return "Записи с"
        case .certificate:
            return "Сертификат"
        case .diploma:
            return "Диплом"
        case .medal:
            return "Медаль"
        case .app:
            return "Приложение"
        case .game:
            return "Игра"
        case .website:
            return "Сайт"
        case .chatbot:
            return "Чат-бот"
        case .framework:
            return "Фреймворк"
        case .office:
            return "в офисе"
        case .contract:
            return "по контракту"
        case .remote:
            return "удаленка"
        case .freelance:
            return "на фрилансе"
        case .freeSchedule:
            return "свободный график"
        case .allPosts:
            return "Все посты"
        case .listAllPosts:
            return "Список всех постов"
        }
    }
    
    var english: String {
        switch self {
        case .websiteName:
            return "Nikolai Trukhin's website"
        case .websiteDescription:
            return "Here is all the information about projects, events, books, and more"
        case .localeIdentifier:
            return "en_US"
        case .untilNow:
            return " - now"
        case .availableOn:
            return "Available on"
        case .back:
            return "Back"
        case .page:
            return "Page"
        case .next:
            return "Next"
        case .latestPosts:
            return "Latest posts"
        case .nikolaiTrukhin:
            return "Nikolai Trukhin"
        case .positionTitle:
            return "iOS developer"
        case .generatedUsing:
            return "Generated using"
        case .rssChannel:
            return "RSS channel"
        case .chronology:
            return "Chronology"
        case .otherPosts:
            return "Other posts"
        case .subscribeTo:
            return "Subscribe to"
        case .projects:
            return "Projects"
        case .books:
            return "Books"
        case .events:
            return "Events"
        case .career:
            return "Career"
        case .achievements:
            return "Achievements"
        case .otherTags:
            return "Other tags"
        case .postsWidth:
            return "Posts with"
        case .certificate:
            return "Certificate"
        case .diploma:
            return "Diploma"
        case .medal:
            return "Medal"
        case .app:
            return "App"
        case .game:
            return "Game"
        case .website:
            return "Website"
        case .chatbot:
            return "Chatbot"
        case .framework:
            return "Framework"
        case .office:
            return "office"
        case .contract:
            return "contract"
        case .remote:
            return "remote"
        case .freelance:
            return "freelance"
        case .freeSchedule:
            return "free schedule"
        case .allPosts:
            return "All posts"
        case .listAllPosts:
            return "List of all posts"
        }
    }
    
    var allTranslations: [Language: String] {
        [
            .russian: russian,
            .english: english
        ]
    }
}

extension Language {
    
    static var `default`: Self { .english }
    
    func localized(_ phrase: LocalizablePhrase) -> String {
        switch self {
        case .russian:
            return phrase.russian
            
        default:
            return phrase.english
        }
    }

}

extension Optional where Wrapped == Language {
    func localized(_ phrase: LocalizablePhrase) -> String {
        if let self = self {
            return self.localized(phrase)
        }
        return Language.default.localized(.untilNow)
    }
}
