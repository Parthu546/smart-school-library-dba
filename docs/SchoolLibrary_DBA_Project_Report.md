# Smart School Library — Database Administration (DBA) Project Report

## 1. Executive Summary & Objective
This project implements an enterprise-grade **Database Administration (DBA)** solution for a **Smart School Library Management System** using **MySQL 8.0**. Beyond basic CRUD operations, the architecture enforces strict referential integrity, database-level event automation via triggers and stored procedures, Role-Based Access Control (RBAC), B-Tree index optimization, and logical disaster recovery.

## 2. Entity-Relationship (ER) & Schema Design
Normalized to **Third Normal Form (3NF)** across four tables:
1. **`Students`**: `student_id` (PK), `student_name`, `grade`
2. **`Books`**: `book_id` (PK), `title`, `author`, `copies_available` (`CHECK (copies_available >= 0)`)
3. **`Issued_Books`**: `issue_id` (PK), `student_id` (FK), `book_id` (FK), `issue_date`, `due_date`, `return_date`, `status` (ENUM), `fine_amount`
4. **`Audit_Log`**: `log_id` (AUTO_INCREMENT PK), `action_type`, `table_name`, `record_id`, `action_timestamp`, `performed_by`

## 3. Core DBA Implementations
- **Data Integrity:** Foreign key constraints (`issued_books_ibfk_1`, `issued_books_ibfk_2`), `CHECK` constraints, and `ENUM` status validation.
- **Automation & Auditing:** `after_book_issue` and `after_book_return` triggers sync book inventory and write audit entries with `USER()` and `CURRENT_TIMESTAMP`. `ReturnBook` stored procedure calculates overdue fines at Rs. 5/day.
- **Performance Optimization:** Composite B-Tree indexes (`idx_books_title_author`, `idx_issued_status_due`) verified via `EXPLAIN`.
- **Security (RBAC):** Least-privilege roles (`library_staff` and `read_only_auditor`) assigned to `librarian_user` and `auditor_user`.
- **Reporting & Recovery:** `Overdue_Books_Report` view and logical dumps via `mysqldump --routines --triggers`.
