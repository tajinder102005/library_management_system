# Library Management System - Quick Start Guide

## 🚀 Get Started in 3 Steps

### Step 1: Start MongoDB
```bash
# Make sure MongoDB is running on localhost:27017
mongod --version
```

### Step 2: Run the Application
```bash
cd library-management-system
mvn clean tomcat7:run
```

### Step 3: Access the Application
Open your browser and go to: **http://localhost:8080**

## 🔑 Login Credentials

### For Administrators
```
Username: admin
Password: admin123
```

### For Students
```
Username: student
Password: student123
```

## 📋 Common Tasks

### As an Administrator

#### Add a New Book
1. Login as admin
2. Click "Manage Books" in sidebar
3. Click "Add New Book" button
4. Fill in book details
5. Click "Add Book"

#### Issue a Book
1. Click "Book Issues" in sidebar
2. Click "Issue Book" button
3. Select book from dropdown
4. Select student from dropdown
5. Click "Issue Book"

#### Return a Book
1. Click "Book Issues" in sidebar
2. Click "Return Book" button
3. Find the book in the list
4. Click "Return" button

#### Add a New User
1. Click "Manage Users" in sidebar
2. Click "Add User" button
3. Fill in user details
4. Select role (Student/Librarian/Admin)
5. Click "Add User"

### As a Student

#### Search for Books
1. Login as student
2. Click "Search Books" in sidebar
3. Enter search term
4. Click "Search"
5. View available books

#### View My Issued Books
1. Click "My Books" in sidebar
2. See all currently issued books
3. Check due dates

#### View Borrowing History
1. Click "Borrowing History" in sidebar
2. See complete history
3. Check return dates

## 🎯 Quick Navigation

### Admin Dashboard
- **Dashboard** - Overview and statistics
- **Manage Books** - Add, edit, delete, search books
- **Book Issues** - Issue, return, view all issues
- **Manage Users** - Add, edit, delete users
- **Reports** - View analytics and reports

### Student Dashboard
- **Dashboard** - Personal overview
- **Search Books** - Find available books
- **My Books** - Currently issued books
- **Borrowing History** - Past transactions
- **My Profile** - Personal information

## ⚡ Keyboard Shortcuts

- **Tab** - Navigate between fields
- **Enter** - Submit forms
- **Esc** - Close modals/alerts
- **Ctrl+F** - Search on page

## 💡 Tips & Tricks

### For Administrators
1. Use the search feature to quickly find books
2. Check the dashboard for overdue books
3. View reports for library statistics
4. Edit books to update copy counts
5. Deactivate users instead of deleting them

### For Students
1. Check "My Books" regularly for due dates
2. Use search to find specific books
3. View history to track your reading
4. Update your profile information
5. Note the 14-day loan period

## 🔍 Search Tips

### Search Books
- Search by **title**: "Java Programming"
- Search by **author**: "Joshua Bloch"
- Search by **ISBN**: "978-0134685991"
- Search by **category**: "Technology"

### Partial Matches
- "Java" will find "Effective Java", "Head First Java", etc.
- Search is case-insensitive
- Searches across all fields

## 📊 Understanding Status Indicators

### Book Status
- 🟢 **Available** - Book can be issued
- 🔴 **Out of Stock** - All copies issued

### Issue Status
- 🔵 **Issued** - Book currently with student
- 🟢 **Returned** - Book returned
- 🟡 **Overdue** - Past due date

### User Status
- 🟢 **Active** - Can login and use system
- 🔴 **Inactive** - Account disabled

## ⚠️ Important Notes

### Book Issuance Rules
- Maximum **5 books** per student
- Loan period: **14 days**
- Cannot issue same book twice to same student
- Must have available copies

### Password Security
- Passwords are encrypted
- Cannot be recovered (only reset)
- Use strong passwords
- Don't share credentials

### Data Management
- All data stored in MongoDB
- Automatic backups recommended
- Regular database maintenance
- Keep MongoDB running

## 🆘 Troubleshooting

### Cannot Login
- Check username and password
- Ensure account is active
- Clear browser cache
- Try different browser

### Page Not Found (404)
- Check URL spelling
- Ensure you're logged in
- Verify user role permissions
- Restart server if needed

### Book Not Available
- Check available copies count
- View who has the book issued
- Wait for return or add more copies

### Server Not Starting
- Check if MongoDB is running
- Verify port 8080 is free
- Check Java version (11+)
- Review console errors

## 📞 Getting Help

### Documentation
- **README.md** - Complete documentation
- **DEPLOYMENT_GUIDE.md** - Setup instructions
- **TESTING_GUIDE.md** - Test scenarios
- **FEATURES.md** - Feature list

### Support
- Check documentation first
- Review error messages
- Test with sample data
- Verify MongoDB connection

## 🎓 Learning Resources

### For Developers
- Study the code structure
- Review servlet implementations
- Understand DAO pattern
- Explore MongoDB queries

### For Users
- Explore all menu options
- Try different searches
- View sample data
- Practice common tasks

## 🔄 Regular Maintenance

### Daily
- Check overdue books
- Monitor active issues
- Review new registrations

### Weekly
- Generate reports
- Review user activity
- Check system performance

### Monthly
- Database backup
- User account review
- System updates

## 📈 Best Practices

### For Librarians
1. Issue books promptly
2. Track overdue books
3. Keep book records updated
4. Maintain user accounts
5. Generate regular reports

### For Students
1. Return books on time
2. Check due dates regularly
3. Keep profile updated
4. Report issues promptly
5. Use search effectively

## 🎉 Success Checklist

- [ ] MongoDB is running
- [ ] Application started successfully
- [ ] Can login as admin
- [ ] Can login as student
- [ ] Can add a book
- [ ] Can issue a book
- [ ] Can return a book
- [ ] Can search books
- [ ] Can view reports
- [ ] All features working

## 🌟 Next Steps

1. **Explore** - Try all features
2. **Customize** - Add your own data
3. **Test** - Verify all workflows
4. **Deploy** - Move to production
5. **Monitor** - Track usage

---

**Need More Help?**
- Read the full README.md
- Check TESTING_GUIDE.md
- Review FEATURES.md
- Consult DEPLOYMENT_GUIDE.md

**Application URL:** http://localhost:8080
**Status:** ✅ Ready to Use!