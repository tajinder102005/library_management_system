# Library Management System - Testing Guide

## Test Scenarios

### 1. Authentication Tests

#### Test 1.1: Admin Login
- **URL:** `http://localhost:8080/login.jsp`
- **Credentials:** admin / admin123
- **Expected:** Redirect to `/admin/dashboard.jsp`
- **Verify:** Dashboard shows statistics, purple theme

#### Test 1.2: Student Login
- **URL:** `http://localhost:8080/login.jsp`
- **Credentials:** student / student123
- **Expected:** Redirect to `/student/dashboard.jsp`
- **Verify:** Dashboard shows student info, green theme

#### Test 1.3: Invalid Login
- **Credentials:** invalid / invalid
- **Expected:** Error message "Invalid username or password"

#### Test 1.4: Logout
- **Action:** Click Logout from any page
- **Expected:** Redirect to login page, session cleared

### 2. Book Management Tests (Admin Only)

#### Test 2.1: View All Books
- **URL:** `/books?action=list`
- **Expected:** List of all books with details
- **Verify:** 10 sample books displayed

#### Test 2.2: Add New Book
- **URL:** `/books?action=add`
- **Test Data:**
  - ISBN: 978-1234567890
  - Title: Test Book
  - Author: Test Author
  - Category: Technology
  - Total Copies: 5
- **Expected:** Success message, book appears in list

#### Test 2.3: Add Duplicate ISBN
- **Action:** Try adding book with existing ISBN
- **Expected:** Error "A book with this ISBN already exists"

#### Test 2.4: Edit Book
- **Action:** Click edit on any book
- **Change:** Update title or copies
- **Expected:** Success message, changes reflected

#### Test 2.5: Delete Book
- **Action:** Click delete, confirm
- **Expected:** Book removed from list

#### Test 2.6: Search Books
- **Action:** Search for "Java"
- **Expected:** Only books matching "Java" displayed

#### Test 2.7: View Book Details
- **Action:** Click view icon on any book
- **Expected:** Detailed book information page

### 3. Book Issue Tests (Admin Only)

#### Test 3.1: Issue Book
- **URL:** `/issues?action=issue`
- **Action:** Select book and student, submit
- **Expected:** Success message, available copies decreased

#### Test 3.2: Issue Same Book Twice
- **Action:** Try issuing same book to same student
- **Expected:** Error "This student already has this book issued"

#### Test 3.3: Issue Unavailable Book
- **Action:** Try issuing book with 0 available copies
- **Expected:** Error "Book is not available"

#### Test 3.4: Return Book
- **URL:** `/issues?action=return`
- **Action:** Click return on issued book
- **Expected:** Success message, available copies increased

#### Test 3.5: View All Issues
- **URL:** `/issues?action=list`
- **Expected:** List of all book issues with status

#### Test 3.6: View Overdue Books
- **URL:** `/issues?action=overdue`
- **Expected:** List of overdue books (if any)

### 4. User Management Tests (Admin Only)

#### Test 4.1: View All Users
- **URL:** `/users?action=list`
- **Expected:** List of all users with roles

#### Test 4.2: Add New User
- **URL:** `/users?action=add`
- **Test Data:**
  - Username: testuser
  - Password: test123
  - Full Name: Test User
  - Email: test@test.com
  - Role: STUDENT
- **Expected:** Success message, user in list

#### Test 4.3: Edit User
- **Action:** Click edit on any user
- **Change:** Update email or role
- **Expected:** Changes saved successfully

#### Test 4.4: Delete User
- **Action:** Click delete, confirm
- **Expected:** User removed from list

### 5. Student Portal Tests

#### Test 5.1: Search Books (Student)
- **URL:** `/books?action=search`
- **Action:** Search for books
- **Expected:** Student-themed search page with book cards

#### Test 5.2: View My Books
- **URL:** `/student/my-books.jsp`
- **Expected:** List of currently issued books

#### Test 5.3: View History
- **URL:** `/student/history.jsp`
- **Expected:** Complete borrowing history

#### Test 5.4: View Profile
- **URL:** `/student/profile.jsp`
- **Expected:** Student profile information

### 6. Reports Tests (Admin Only)

#### Test 6.1: View Reports
- **URL:** `/reports`
- **Expected:** Statistics dashboard with:
  - Total books
  - Available books
  - Issued books
  - Overdue count
  - Books by category
  - Summary information

### 7. Security Tests

#### Test 7.1: Access Admin Page as Student
- **Action:** Login as student, try accessing `/admin/dashboard.jsp`
- **Expected:** Redirect to student dashboard

#### Test 7.2: Access Student Page as Admin
- **Action:** Login as admin, try accessing `/student/dashboard.jsp`
- **Expected:** Redirect to admin dashboard

#### Test 7.3: Access Without Login
- **Action:** Try accessing any protected page without login
- **Expected:** Redirect to login page

### 8. Data Validation Tests

#### Test 8.1: Empty Form Submission
- **Action:** Submit book/user form with empty required fields
- **Expected:** Browser validation prevents submission

#### Test 8.2: Invalid Date Format
- **Action:** Enter invalid date in book form
- **Expected:** Error message

#### Test 8.3: Negative Copies
- **Action:** Enter negative number for book copies
- **Expected:** Browser validation prevents submission (min=1)

### 9. Navigation Tests

#### Test 9.1: Sidebar Navigation
- **Action:** Click each menu item
- **Expected:** Correct page loads, active state updates

#### Test 9.2: Breadcrumb Navigation
- **Action:** Use back buttons on forms
- **Expected:** Return to previous page

#### Test 9.3: Logo/Home Link
- **Action:** Click logo or home
- **Expected:** Return to appropriate dashboard

### 10. UI/UX Tests

#### Test 10.1: Responsive Design
- **Action:** Resize browser window
- **Expected:** Layout adapts to screen size

#### Test 10.2: Icons Display
- **Action:** Check all pages
- **Expected:** Font Awesome icons load correctly

#### Test 10.3: Color Themes
- **Verify:** Admin pages use purple gradient
- **Verify:** Student pages use green gradient

#### Test 10.4: Success/Error Messages
- **Action:** Perform various operations
- **Expected:** Appropriate feedback messages display

## Performance Tests

### Test P.1: Large Dataset
- **Action:** Add 100+ books
- **Expected:** Pages load within 2 seconds

### Test P.2: Concurrent Users
- **Action:** Multiple users login simultaneously
- **Expected:** No conflicts, data integrity maintained

### Test P.3: Search Performance
- **Action:** Search with various terms
- **Expected:** Results return quickly

## Database Tests

### Test D.1: Data Persistence
- **Action:** Add data, restart server
- **Expected:** Data persists in MongoDB

### Test D.2: Relationship Integrity
- **Action:** Delete book with active issues
- **Expected:** Handle gracefully (should prevent or cascade)

### Test D.3: Duplicate Prevention
- **Action:** Try creating duplicate ISBN/username
- **Expected:** Appropriate error message

## Bug Tracking

| Test ID | Status | Issue | Priority |
|---------|--------|-------|----------|
| - | - | - | - |

## Test Results Summary

- **Total Tests:** 40+
- **Passed:** _____
- **Failed:** _____
- **Blocked:** _____
- **Not Tested:** _____

## Notes

- All tests should be performed on a clean database
- Test with different browsers (Chrome, Firefox, Edge)
- Document any unexpected behavior
- Verify MongoDB is running before testing