require 'rails_helper'

# Test: Title
RSpec.describe Book, type: :model do
  subject do
    described_class.new(title: 'twilight', author: 'Stephenie Meyer', price: '1.99', publishedDate: '2019-09-09 00:00:00 UTC')
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.title = nil
    expect(subject).not_to be_valid
  end
end

# Test: Author
RSpec.describe Book, type: :model do
    subject do
        described_class.new(title: 'twilight', author: 'Stephenie Meyer', price: '1.99', publishedDate: '2019-09-09 00:00:00 UTC')
    end
  
    it 'is valid with valid author' do
      expect(subject).to be_valid
    end
  
    it 'is not valid without an author' do
      subject.author = nil
      expect(subject).not_to be_valid
    end
  end

# Test: Price
RSpec.describe Book, type: :model do
    subject do
        described_class.new(title: 'twilight', author: 'Stephenie Meyer', price: '1.99', publishedDate: '2019-09-09 00:00:00 UTC')
    end
  
    it 'is valid with valid price' do
      expect(subject).to be_valid
    end
  
    it 'is not valid without a price' do
      subject.price = nil
      expect(subject).not_to be_valid
    end
  end

# Test: Published Date
RSpec.describe Book, type: :model do
    subject do
        described_class.new(title: 'twilight', author: 'Stephenie Meyer', price: '1.99', publishedDate: '2019-09-09 00:00:00 UTC')
    end
  
    it 'is valid with valid published date' do
      expect(subject).to be_valid
    end
  
    it 'is not valid without a published date' do
      subject.price = nil
      expect(subject).not_to be_valid
    end
  end
