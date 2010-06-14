require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "MongoMapper::Plugins::Paranoid" do
  describe "A paranoid model" do
    it "should get deleted_at added to it" do
      ParanoidItem.keys.keys.should include("deleted_at")
    end

    it "should not be deleted when it's told" do
      @item = ParanoidItem.create(:title => "test")
      lambda{
        @item.destroy
      }.should_not change(ParanoidItem, :count).from(1).to(0)
    end

    it "should set deleted_at to now when deleted" do
      # MM strips milliseconds on save, so make sure we're comparing like with like
      now = Time.at(Time.now.to_i).utc
      Time.stub!(:now).and_return(now)

      @item = ParanoidItem.create(:title => "test")
      lambda{
        @item.destroy
      }.should change(@item, :deleted_at).from(nil).to(now)
    end
  end

  describe "A non-paranoid model" do
    it "should not get deleted_at added to it" do
      NormalItem.keys.keys.should_not include("deleted_at")
    end

    it "should be deleted when it's told" do
      @item = NormalItem.create(:title => "test")
      lambda{
        @item.destroy
      }.should change(NormalItem, :count).from(1).to(0)
    end
  end
end