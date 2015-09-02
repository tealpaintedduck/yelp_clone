require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }

  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless it has a unique name' do
    Restaurant.create(name: "Moe's Tavern")
    restaurant = Restaurant.new(name: "Moe's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end

  describe 'deleting Restaurant' do
    let(:kfc){ Restaurant.create(name: 'KFC') }

    #find out what is going on. doubles for testing class? doubles in database? IS IT EVEN A DOUBLE?!
    it 'deletes reviews' do
      kfc.reviews.create(thoughts: "so so", rating: "3")
      expect{ kfc.destroy }.to change(Review, :count)
    end
  end


end