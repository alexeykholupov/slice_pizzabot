RSpec.describe Pizzabot do
  describe '#initialize' do
    let(:correct_delivery_string)  { '2x2 (1,1) (0,2) (1,2) (0,1)' }
    let(:incorrect_grid)           { 'dxd (0,1) (0,2) (1,0) (1,1)' }
    let(:incorrect_address)        { '3x3 (0,asd) (0,2) (1,0) (1,1)' }
    let(:not_in_delivery_range)    { '1x1 (0,1) (0,2) (1,0) (1,1)' }
    let(:negative_numbers_address) { '1x1 (0,-1) (0,2) (-1,0) (1,1)' }

    it 'should create pizzabot instance with correct delivery string' do
      pizzabot = Pizzabot.new(correct_delivery_string)

      expect(pizzabot.route).to eq([[0, 1], [0, 2], [1, 1], [1, 2]])
      expect(pizzabot.delivery_process).to eq('')
      expect(pizzabot.current_position).to eq([0, 0])
    end

    it 'should raise error with message if grid is incorrect' do
      expect { Pizzabot.new(incorrect_grid) }
        .to raise_error(GridError, 'Grid in wrong format')
    end

    it 'should raise error with message if address has negative numbers' do
      expect { Pizzabot.new(negative_numbers_address) }
        .to raise_error(AddressError, 'Address should not have negative numbers')
    end

    it 'should raise error with message if address is incorrect' do
      expect { Pizzabot.new(incorrect_address) }
        .to raise_error(AddressError, 'Wrong format address: 0,asd')
    end

    it 'should raise error with message if address is not in delivery range' do
      expect { Pizzabot.new(not_in_delivery_range) }
        .to raise_error(AddressError, 'Address is not in delivery range')
    end

    it 'should raise error with message if nil argument given' do
      expect { Pizzabot.new(nil) }
        .to raise_error(ArgumentError, 
                        'You should provide delivery string to pizzabot, '\
                        'example: pizzabot "2x2 (0,1) (0,2)"')
    end
  end

  describe '#deliver' do
    it 'should return delivery process' do
      expect(Pizzabot.new('1x1 (0,1)').deliver).to eq('ND')
    end
  end
end
