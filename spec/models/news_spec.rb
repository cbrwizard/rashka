require 'spec_helper'

describe News do
  it 'is invalid without contents' do
    news = News.new
    news.should_not be_valid
  end
  it 'should allow normal news' do
    news = News.new
    news.title = "Хакеры от лица волгоградской прокуратуры заявили о запрете биткоин-бирж"
    news.text = "На сайте волгоградской прокуратуры в ночь на 4 февраля появилась новость об уголовном деле в отношении популярных обменников криптовалют. Позднее в ведомстве заявили, что пресс-релиз появился из-за хакерской атаки."
    news.link = "http://tjournal.ru/paper/volograd-bitcoin"
    news.should be_valid
  end
  it 'should not be a dublicate' do
    news1 = News.new
    news1.title = "Хакеры от лица волгоградской прокуратуры заявили о запрете биткоин-бирж"
    news1.text = "На сайте волгоградской прокуратуры в ночь на 4 февраля появилась новость об уголовном деле в отношении популярных обменников криптовалют. Позднее в ведомстве заявили, что пресс-релиз появился из-за хакерской атаки."
    news1.link = "http://tjournal.ru/paper/volograd-bitcoin"

    news2 = News.new
    news2.title = "Хакеры от лица волгоградской прокуратуры заявили о запрете биткоин-бирж"
    news2.text = "На сайте волгоградской прокуратуры в ночь на 4 февраля появилась новость об уголовном деле в отношении популярных обменников криптовалют. Позднее в ведомстве заявили, что пресс-релиз появился из-за хакерской атаки."
    news2.link = "http://tjournal.ru/paper/volograd-bitcoin"
    news2.should_not be_valid
  end
end
