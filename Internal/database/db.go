// CreateUserTransaction registers a user and initializes their application profile atomically
func CreateUserTransaction(ctx context.Context, name, email string) (int64, error) {
	// 1. Begin a transactional session context
	tx, err := db.BeginTx(ctx, &sql.TxOptions{Isolation: sql.LevelReadCommitted})
	if err != nil {
		logger.Error("failed to initialize transaction context", "error", err)
		return 0, err
	}

	// 2. Ensure a rollback execution occurs if an early return triggers
	defer func() {
		if err != nil {
			if rbErr := tx.Rollback(); rbErr != nil {
				logger.Error("critical transaction rollback failure", "error", rbErr)
			}
		}
	}()

	// 3. Statement A: Insert User
	var newID int64
	userQuery := "INSERT INTO users (name, email) VALUES ($1, $2) RETURNING id"
	err = tx.QueryRowContext(ctx, userQuery, name, email).Scan(&newID)
	if err != nil {
		logger.Warn("user transaction insertion aborted", "email", email, "error", err)
		return 0, err // Triggers deferred Rollback()
	}

	// 4. Statement B: Update dependent tables or internal tracking logs
	logQuery := "INSERT INTO audit_logs (user_id, action) VALUES ($1, 'account_creation')"
	_, err = tx.ExecContext(ctx, logQuery, newID)
	if err != nil {
		logger.Warn("audit logging transaction step failed", "user_id", newID, "error", err)
		return 0, err // Triggers deferred Rollback()
	}

	// 5. Commit all execution changes down to persistent storage safely
	if err = tx.Commit(); err != nil {
		logger.Error("failed to commit transaction", "error", err)
		return 0, err
	}

	return newID, nil
}

