namespace FourK.Models {
	internal class Game {
		private Models.Board board;
		private int move_counter;
		private int current_score;
		private int high_score;
		private bool game_over_state;

		public signal void board_updated (int[,] board_state);

		private GLib.Settings settings;

		public Game () {
			board = new Board ();
			settings = new GLib.Settings ("com.github.keilith-l.fourk");
			load_state ();
			start_new_game ();
		}

		public void start_new_game () {
			board.clear_board ();
			reset_move_counter ();
			current_score = 0;
			game_over_state = false;
			board.spawn_first_tile ();
		}

		public void move (FourK.Directions direction) {
			if (!is_move_valid(direction)) {
				return;
			}
			switch (direction) {
				case FourK.Directions.UP:
					board.shift_cols_up ();
					break;
				case FourK.Directions.DOWN:
					board.shift_cols_down ();
					break;
				case FourK.Directions.LEFT:
					board.shift_rows_left ();
					break;
				case FourK.Directions.RIGHT:
					board.shift_rows_right ();
					break;
			}
			calculate_current_score ();
			increment_move_counter ();
			board.spawn_tile ();
			update_game_over_state ();
			return;
		}

		public int[,] get_board_state () {
			return board.get_state ();
		}

		public int get_current_score () {
			return current_score;
		}

		public int get_high_score () {
			return high_score;
		}

		public bool is_game_over () {
			return game_over_state;
		}

		public int get_largest_tile () {
			return board.get_largest_tile_value ();
		}

		public void load_state () {
			settings.get("highest-score", "i", out high_score);
		}

		public void save_state () {
			settings.set("highest-score", "i", high_score);
		}

		private void calculate_current_score () {
			int score = current_score;
			int[,] board_state = board.get_state();
			bool[,] merge_state = board.get_merged_tiles_state ();

			for (int r = 0; r < 4; r++) {
				for (int c = 0; c < 4; c++) {
					if (merge_state[c,r] == true) {
						score = score + board_state[c,r];
					}
				}
			}

			current_score = score;
			if (current_score > high_score) {
				high_score = current_score;
				save_state ();
			}
			board.reset_tile_merge_states ();
		}

		private void increment_move_counter () {
			move_counter = move_counter + 1;
		}

		private void reset_move_counter () {
			move_counter = 0;
		}

		private void update_game_over_state () {
			var valid_moves = board.get_valid_moves ();
			if (valid_moves[Directions.LEFT] == true ||
				valid_moves[Directions.RIGHT] == true ||
				valid_moves[Directions.UP] == true ||
				valid_moves[Directions.DOWN] == true
			) {
				game_over_state = false;
			} else {
				game_over_state = true;
			}
		}

		private bool is_move_valid (FourK.Directions direction) {
			return board.get_valid_moves ()[direction];
		}
	}
}
