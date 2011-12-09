describe 'owner_of(model)' do
  describe 'can' do
    before do
      subject.owner_of(Post).can(:edit)
    end
    specify { subject.can?(:edit, Post).should be_true }
  end

  describe 'cannot' do
    before do
      subject.owner_of(Post).can(:edit)
    end
    specify { subject.can?(:edit, Post).should be_true }
  end

  describe 'block' do
    before do
      subject.owner_of(Post) do |owner|
        owner.can(:edit)
        owner.cannot(:publish)
      end
    end
    specify { subject.can?(:edit, Post).should be_true }
    specify { subject.can?(:publish, Post).should be_false }
    specify { subject.cannot?(:publish, Post).should be_true }
  end
end

describe 'scope(name, &block)' do
end