shared_examples_for 'CanTango::Api::Ability::Dsl::Relationship' do
  describe 'owner_of(model)' do
    describe 'can' do
      before do
        subject.owner_of(Project).can(:edit)
      end
      specify { subject.can?(:edit, Project).should be_true }
    end

    describe 'cannot' do
      before do
        subject.owner_of(Project).can(:edit)
      end
      specify { subject.can?(:edit, Project).should be_true }
    end

    describe 'block' do
      before do
        subject.owner_of(Project) do |owner|
          owner.can(:edit)
          owner.cannot(:publish)
        end
      end
      specify { subject.can?(:edit, Project).should be_true }
      specify { subject.can?(:publish, Project).should be_false }
      specify { subject.cannot?(:publish, Project).should be_true }
    end
  end
end