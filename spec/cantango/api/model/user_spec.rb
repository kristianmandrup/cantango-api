describe 'Model API included' do
  [:active_user, :can?, :cannot?].each do |name|
    specify { subject.should respond_to name }
  end
end
