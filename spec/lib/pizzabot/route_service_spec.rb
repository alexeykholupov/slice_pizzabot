RSpec.describe RouteService do
  describe '#initialize' do
    it 'should create RouteService instance' do
      route_service = RouteService.new('1x1 (0,1)')

      expect(route_service.grid).to eq([1, 1])
      expect(route_service.addresses).to eq(['0,1'])
    end
  end

  describe '#prepare_route' do
    let(:correct_delivery_string)  { '2x2 (1,1) (0,2) (1,2) (0,1)' }
    let(:incorrect_grid)           { 'dxd (0,1) (0,2) (1,0) (1,1)' }
    let(:incorrect_address)        { '3x3 (0,asd) (0,2) (1,0) (1,1)' }
    let(:not_in_delivery_range)    { '1x1 (0,1) (0,2) (1,0) (1,1)' }
    let(:negative_numbers_address) { '1x1 (0,-1) (0,2) (-1,0) (1,1)' }

    it 'should return sorted array of addresses' do
      route_service = RouteService.new(correct_delivery_string)

      expect(route_service.prepare_route).to eq([[0, 1], [0, 2], [1, 1], [1, 2]])
    end

    it 'should raise error with message if grid is incorrect' do
      expect { RouteService.new(incorrect_grid).prepare_route }
        .to raise_error(GridError, 'Grid in wrong format')
    end

    it 'should raise error with message if address has negative numbers' do
      expect { RouteService.new(negative_numbers_address).prepare_route }
        .to raise_error(AddressError, 'Address should not have negative numbers')
    end

    it 'should raise error with message if address is incorrect' do
      expect { RouteService.new(incorrect_address).prepare_route }
        .to raise_error(AddressError, 'Wrong format address: 0,asd')
    end

    it 'should raise error with message if address is not in delivery range' do
      expect { RouteService.new(not_in_delivery_range).prepare_route }
        .to raise_error(AddressError, 'Address is not in delivery range')
    end
  end
end
