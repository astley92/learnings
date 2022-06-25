RSpec.describe "Adding a webhook and testing its connection", type: :feature do
  before do
    user = create(:user)
    sign_in(user)
  end

  it "Allows adding a webhook and checking it's connection" do
    visit("/dashboard")
    expect(page.text).to include("Add Webhook")
    click_on("Add Webhook")

    expect(current_path).to eq("/webhook")
    expect(page.text).to include("Enter Webhook URL")
    fill_in("webhook_url", with: "https://localhost:5000")
    click_on("Confirm")

    expect(current_path).to eq("/webhook")
    expect(page.text).to include("https://localhost:5000")
    expect(page.text).to include("Check Connection")
  end
end
