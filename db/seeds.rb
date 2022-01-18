admin = Admin.find_or_initialize_by(email: 'admin@localhost.com', name: 'Admin')
admin.status = 'active'
admin.password = '123456'
admin.save