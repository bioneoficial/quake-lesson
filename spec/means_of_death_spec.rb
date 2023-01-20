require 'rspec'
require_relative '../means_of_death'

describe MeansOfDeath do
  describe 'MODS' do
    it 'contains a key-value pair for each means of death' do
      expect(MeansOfDeath::MODS.size).to eq(29)
    end
    it 'has the correct key-value pair for MOD_SHOTGUN' do
      expect(MeansOfDeath::MODS[1]).to eq('MOD_SHOTGUN')
    end

    it 'has the correct key-value pair for MOD_GRENADE_SPLASH' do
      expect(MeansOfDeath::MODS[5]).to eq('MOD_GRENADE_SPLASH')
    end

    it 'has the correct key-value pair for MOD_SUICIDE' do
      expect(MeansOfDeath::MODS[20]).to eq('MOD_SUICIDE')
    end
  end
end