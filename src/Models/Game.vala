namespace FourK.Models {
	internal class Game {
		private Models.Board board;
		private int move_counter;

		public signal void board_updated (int[,] board_state);

		public Game () {
			board = new Board ();
			start_new_game ();
		}

		public void start_new_game () {
			board.clear_board ();
			reset_move_counter ();
			board.spawn_first_tile ();
		}

		public void move (FourK.Directions direction) {
			if (board.get_valid_moves ()[direction] == false) {
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
			increment_move_counter ();
			board.spawn_tile ();
			return;
		}

		public int[,] get_board_state () {
			return board.get_state ();
		}

		private void increment_move_counter () {
			move_counter = move_counter + 1;
		}

		private void reset_move_counter () {
			move_counter = 0;
		}

		private bool is_move_valid (FourK.Directions directions) {
			return false;
		}
	}
}
