require 'spec_helper'

describe News do
  it 'is invalid without contents' do
    news = News.new
    news.should_not be_valid
  end

  it 'should allow normal news' do
    news = News.new(
        title: "Хакеры от лица пыщьпыщь прокуратуры заявили о запрете биткоин-бирж",
        text: "На сайте волгоградской прокуратуры в ночь на 4 февраля появилась новость об уголовном деле в отношении популярных обменников криптовалют. Позднее в asdasd заявили, что пресс-релиз появился из-за хакерской атаки.",
        link: "http://tjournal.ru/paper/asdvolograd-bitcoin")
    news.should be_valid
  end

  it 'should not allow a dublicate' do
    News.create(
        title: "Хакеры от лица пыщьпыщь прокуратуры заявили о запрете биткоин-бирж",
        text: "На сайте волгоградской прокуратуры в ночь на 4 февраля появилась новость об уголовном деле в отношении популярных обменников криптовалют. Позднее в asdasd заявили, что пресс-релиз появился из-за хакерской атаки.",
        link: "http://tjournal.ru/paper/asdvolograd-bitcoin")

    news2 = News.create(
        title: "Хакеры от лица пыщьпыщь прокуратуры заявили о запрете биткоин-бирж",
        text: "На сайте волгоградской прокуратуры в ночь на 4 февраля появилась новость об уголовном деле в отношении популярных обменников криптовалют. Позднее в asdasd заявили, что пресс-релиз появился из-за хакерской атаки.",
        link: "http://tjournal.ru/paper/asdvolograd-bitcoin")
    news2.should_not be_valid
  end
end
