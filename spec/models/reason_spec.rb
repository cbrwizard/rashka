require 'spec_helper'

describe Reason do
  it 'is invalid without text' do
    reason = Reason.new
    reason.should_not be_valid
  end

  it 'should not allow short text' do
    reason = Reason.new(text: 1)
    reason.should_not be_valid
  end

  it 'should not allow a dublicate' do
    Reason.create(
      text: "Хакеры от лица волгоградской прокуратуры заявили о запрете биткоин-бирж")

    reason2 = Reason.create(
      text: "Хакеры от лица волгоградской прокуратуры заявили о запрете биткоин-бирж")
    reason2.should_not be_valid
  end

  it 'should not allow long text' do
    reason = Reason.new(
        text: "На сайте волгоградской прокуратуры в ночь на 4 февраля появилась новость об уголовном деле в отношении популярных обменников криптовалют. Позднее в ведомстве заявили, что пресс-релиз появился из-за хакерской атаки.")
    reason.should_not be_valid
  end

  it 'should increase popularity' do
    reason = Reason.create(
        text: "Хакеры от лица волгоградской прокуратуры заявили о запрете биткоин-бирж")
    reason.increase_popularity
    reason.popularity.should == 2
  end

  it 'should not add same reason' do
    Reason.create(
        text: "Хакеры от лица волгоградской прокуратуры заявили о запрете биткоин-бирж")

    reason2 = Reason.new(
        text: "Хакеры от лИца волгоградской проКУратуры заявили о запрете биткоин-БИРЖ")
    reason2.try_to_save
    reason2.should_not be_valid
  end
end
