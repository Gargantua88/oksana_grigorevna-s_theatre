require 'rails_helper'

RSpec.describe PerfomancesController, type: :controller do

  let(:perfomance1) { Perfomance.create(title: 'The Marriage of Figaro',
                                        start_date: '2019.01.01',
                                        finish_date: '2019.03.03')
  }

  let(:perfomance2) { Perfomance.create(title: 'Cats',
                                        start_date: '2019.03.04',
                                        finish_date: '2019.04.04')
  }

  describe '#create' do
    before do
      @correct_params1 = {
          title: 'The Cherry Orchard',
          start_date: '2019.01.01',
          finish_date: '2019.03.03'
      }

      @correct_params2 = {
          title: 'King Lear',
          start_date: '2019.03.03',
          finish_date: '2019.05.05'
      }
    end

    it 'creates perfomance by params' do
      post :create, params: {perfomance: @correct_params1}

      expect(Perfomance.where(@correct_params1).count).to eq 1
    end

    it 'doesnt creates without title' do
      @incorrect_params = {
          title: '',
          start_date: '2019.01.01',
          finish_date: '2019.03.03'
      }

      post :create, params: {perfomance: @incorrect_params}

      expect(Perfomance.all.length).to eq 0
    end

    it 'doesnt creates by incorrect date' do
      @incorrect_params = {
          title: 'The Cherry Orchard',
          start_date: '2019.01',
          finish_date: '2019.03.03'
      }

      post :create, params: {perfomance: @incorrect_params}

      expect(Perfomance.all.length).to eq 0
    end

    it 'doesnt creates if finish_date > start_date' do
      @incorrect_params = {
          title: 'The Cherry Orchard',
          start_date: '2019.03.03',
          finish_date: '2019.01.01'
      }

      post :create, params: {perfomance: @incorrect_params}

      json_response = JSON.parse(response.body)

      expect(Perfomance.all.length).to eq 0
      expect(json_response['end_date'].first).to eq 'Оксана Григорьевна, проверьте даты!'
    end

    it 'doesnt creates if date is already taken' do
      post :create, params: {perfomance: @correct_params1}
      post :create, params: {perfomance: @correct_params2}

      json_response = JSON.parse(response.body)

      expect(Perfomance.all.length).to eq 1
      expect(Perfomance.first.title).to eq 'The Cherry Orchard'
      expect(json_response['date_range'].first).to eq 'Оксана Григорьевна, на эти даты уже есть спектакль!'
    end
  end

  describe '#index' do
    it 'returns correct result' do
      perfomance1
      perfomance2

      get :index

      json_response = JSON.parse(response.body)

      expect(json_response.length).to eq 2
      expect(json_response.first['title']).to eq 'The Marriage of Figaro'
      expect(json_response.last['title']).to eq 'Cats'
    end
  end

  describe '#delete' do
    it 'deletes perfomance' do
      perfomance1
      perfomance2

      delete :destroy, params: {id: perfomance1.id}

      expect(Perfomance.all.length).to eq 1
      expect(Perfomance.first.title).to eq 'Cats'
    end
  end
end
