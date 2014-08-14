require 'rails_helper'

describe "User pages" do

	subject { page }

	describe "without signing in" do
		let(:user) { FactoryGirl.create(:user) }

		describe "index" do
			before { visit users_path }
			specify { expect(current_path).to eq signin_path }
		end

		describe "new" do
			before { visit new_user_path }
			specify { expect(current_path).to eq signin_path }
		end

		describe "show" do
			before { visit user_path(user) }
			specify { expect(current_path).to eq signin_path }
		end

		describe "edit" do
			before { visit edit_user_path(user) }
			specify { expect(current_path).to eq signin_path }
		end
	end # end without signing in

	describe "with signin in first" do
		let(:signed_in_user) { FactoryGirl.create(:user) }

		before do
			visit signin_path
			fill_in "Email",    with: signed_in_user.email
			fill_in "Password", with: signed_in_user.password
			click_button "Sign in"
		end

		describe "index" do
			before { visit users_path }
			it { should have_content("Listing all users") }
		end

		describe "new" do
			before { visit new_user_path }

			it { should have_content("Username") }
			it { should have_content("Name") }
			it { should have_content("Email") }
			it { should have_content("Password") }
			it { should have_content("Password confirmation") }
			it { should have_button("Create User") }
		end

		describe "show signed_in_user" do
			before { visit user_path(signed_in_user) }

			it { should have_content("Profile") }
			it { should have_content(signed_in_user.username) }
			it { should have_content(signed_in_user.email) }
			it { should have_content(signed_in_user.name) }
		end

		describe "show another_user" do
			let(:another_user) { FactoryGirl.create(:user) }
			before { visit user_path(another_user) }

			it { should have_content("Profile") }
			it { should have_content(another_user.username) }
			it { should have_content(another_user.email) }
			it { should have_content(another_user.name) }
		end

		describe "create new user" do
			let(:submit) { "Create User" }
			before { visit new_user_path }

			describe "with invalid information" do
				it "should not create a user" do
					expect { click_button submit }.not_to change(User, :count)
				end
			end

			describe "with valid information" do
				before do
					fill_in "Username",              with: "username"
					fill_in "Email",                 with: "email@email.com"
					fill_in "Name",                  with: "Name Surname"
					fill_in "Password",              with: "thepass"
					fill_in "Password confirmation", with: "thepass"
				end

				it "should create a user" do
					expect { click_button submit }.to change(User, :count).by(1)
				end

				describe "after creating the user" do
					before { click_button submit }
					let(:user) { User.find_by(email: "email@email.com") }

					it { should have_link("Salir") }
					it { should have_content(user.name) }
					it { should have_selector('div.alert.alert-success', text: 'User created successfully') }
				end
			end
		end

	end # end with signin first

end
