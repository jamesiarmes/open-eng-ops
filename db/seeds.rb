# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Role.create(name: 'admin', human_name: 'Admin', description: 'Admin users have all permissions.')

# Create default permissions for users.
Permission.create!(name: "create_users", controller: "users", description: "can update other users", controller_method: "new")
Permission.create!(name: "delete_users", controller: "users", description: "can delete other users", controller_method: "destroy")
Permission.create!(name: "edit_users", controller: "users", description: "can update other users", controller_method: "update")
Permission.create!(name: "list_users", controller: "users", description: "can list other users", controller_method: "index")
Permission.create!(name: "view_users", controller: "users", description: "can view other users", controller_method: "show")

# Create default permissions for roles.
Permission.create!(name: "create_roles", controller: "roles", description: "can update roles", controller_method: "new")
Permission.create!(name: "delete_roles", controller: "roles", description: "can delete roles", controller_method: "destroy")
Permission.create!(name: "edit_roles", controller: "roles", description: "can update roles", controller_method: "update")
Permission.create!(name: "list_roles", controller: "roles", description: "can list roles", controller_method: "index")
Permission.create!(name: "view_roles", controller: "roles", description: "can view roles", controller_method: "show")

# Create default permissions for services.
Permission.create!(name: "create_services", controller: "services", description: "can update services", controller_method: "new")
Permission.create!(name: "delete_services", controller: "services", description: "can delete services", controller_method: "destroy")
Permission.create!(name: "edit_services", controller: "services", description: "can update services", controller_method: "update")
Permission.create!(name: "list_services", controller: "services", description: "can list services", controller_method: "index")
Permission.create!(name: "view_services", controller: "services", description: "can view services", controller_method: "show")
