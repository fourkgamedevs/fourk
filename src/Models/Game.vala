namespace FourK.Models {
	internal class Game {
		private int[,] board_state;
		private int move_counter;

		public Game () {
			board_state = new int[4,4];
			start_new_game ();
		}

		public void start_new_game () {
			clear_board ();
			reset_move_counter ();
			spawn_first_tile ();
		}

		public int[,] get_board_state () {
			return board_state;
		}

		private void clear_board () {
			for (int y = 0; y < 4; y++) {
				for (int x = 0; x < 4; x++) {
					board_state[x,y] = 0;
				}
			}
		}

		private void reset_move_counter () {
			move_counter = 0;
		}

		private void spawn_first_tile () {
			int val = 2;
			int index_x = GLib.Random.int_range (0,4);
			int index_y = GLib.Random.int_range (0,4);
			board_state[index_x,index_y] = val;
		}
	}
}
