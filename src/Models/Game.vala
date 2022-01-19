namespace FourK.Models {
	internal class Game {
		private int[,] board_state;
		private int move_counter;

		public signal void board_updated (int[,] board_state);

		public Game () {
			board_state = new int[4,4];
			start_new_game ();
		}

		public void start_new_game () {
			clear_board ();
			reset_move_counter ();
			spawn_first_tile ();
		}

		public void move (FourK.Directions direction) {
			switch (direction) {
				case FourK.Directions.UP:
					if (shift_cols_up ()) {
						board_updated (board_state);
						increment_move_counter ();
						spawn_tile ();
					}
					break;
				case FourK.Directions.DOWN:
					if (shift_cols_down ()) {
						board_updated (board_state);
						increment_move_counter ();
						spawn_tile ();
					}
					break;
				case FourK.Directions.LEFT:
					if (shift_rows_left ()) {
						board_updated (board_state);
						increment_move_counter ();
						spawn_tile ();
					}
					break;
				case FourK.Directions.RIGHT:
					if (shift_rows_right ()) {
						board_updated (board_state);
						increment_move_counter ();
						spawn_tile ();
					}
					break;
			}
			return;
		}

		public int[,] get_board_state () {
			return board_state;
		}

		private void increment_move_counter () {
			move_counter = move_counter + 1;
		}

		private void clear_board () {
			for (int y = 0; y < 4; y++) {
				for (int x = 0; x < 4; x++) {
					board_state[x,y] = 0;
				}
			}
		}
		
		private void print_board () {
			for (int y = 0; y < 4; y++) {
				for (int x = 0; x < 4; x++) {
					print (board_state[x,y].to_string () + " ");
				}
				print ("\n");
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
			board_updated (board_state);
		}

		private void spawn_tile () {
			int val = GLib.Random.int_range(1,3);
			val = val*2;

			int num_free_spaces = 0;
			for (int y = 0; y < 4; y++) {
				for (int x = 0; x < 4; x++) {
					if (board_state[x,y] == 0){
						num_free_spaces += 1;
					}
				}
			}

			if (num_free_spaces == 0) {
				return;
			}

			int[,] free_spaces = new int[num_free_spaces,2];
			int index = 0;
			for (int y = 0; y < 4; y++) {
				for (int x = 0; x < 4; x++) {
					if (board_state[x,y] == 0){
						free_spaces[index,0] = x;
						free_spaces[index,1] = y;
						index++;
					}
				}
			}

			int random_index = GLib.Random.int_range(0, num_free_spaces);
			board_state[free_spaces[random_index,0], free_spaces[random_index,1]] = val;
			board_updated (board_state);
		}

		private bool shift_cols_up () {
			int [,] new_state = new int[4,4];
			for (int y = 0; y < 4; y++) {
				for (int x = 0; x < 4; x++) {
					new_state[x,y] = board_state[x,y];
				}
			}

			for(int c = 0; c < 4; c++) {
				// Pull the next non-empty tile to current element
				for (int i = 0; i < 4 - 1; i++) {
					int r = i;
					while (new_state[c,r] == 0 && r < new_state.length[0] - 1) {
						r++;
					}
					if (r > i) {
						new_state[c,i] = new_state[c,r];
						new_state[c,r] = 0;
					}
				}
				// Combine Adjacent Elements that are the same
				for (int i = 0; i < new_state.length[0] - 1; i++) {
					if (new_state[c,i] == new_state[c,i+1]) {
						new_state[c,i] = 2*new_state[c,i];
						new_state[c,i+1] = 0;
					}
				}
				// Pull the next non-empty tile to current element
				for (int i = 0; i < 4 - 1; i++) {
					int r = i;
					while (new_state[c,r] == 0 && r < new_state.length[0] - 1) {
						r++;
					}
					if (r > i) {
						new_state[c,i] = new_state[c,r];
						new_state[c,r] = 0;
					}
				}
			}
			for (int y = 0; y < 4; y++) {
				for (int x = 0; x < 4; x++) {
					if (new_state[x,y] != board_state[x,y]) {
						board_state = new_state;
						return true;
					}
				}
			}
			return false;
		}

		private bool shift_cols_down () {
			int [,] new_state = new int[4,4];
			for (int y = 0; y < 4; y++) {
				for (int x = 0; x < 4; x++) {
					new_state[x,y] = board_state[x,y];
				}
			}
			for(int c = 0; c < 4; c++) {
				// Pull the next non-empty tile to current element
				for (int i = 3; i > 0; i--) {
					int r = i;
					while (new_state[c,r] == 0 && r > 0) {
						r--;
					}
					if (r < i) {
						new_state[c,i] = new_state[c,r];
						new_state[c,r] = 0;
					}
				}
				// Combine Adjacent Elements that are the same
				for (int i = 3; i > 0; i--) {
					if (new_state[c,i] == new_state[c,i-1]) {
						new_state[c,i] = 2*new_state[c,i];
						new_state[c,i-1] = 0;
					}
				}
				// Pull the next non-empty tile to current element
				for (int i = 3; i > 0; i--) {
					int r = i;
					while (new_state[c,r] == 0 && r > 0) {
						r--;
					}
					if (r < i) {
						new_state[c,i] = new_state[c,r];
						new_state[c,r] = 0;
					}
				}
			}

			for (int y = 0; y < 4; y++) {
				for (int x = 0; x < 4; x++) {
					if (new_state[x,y] != board_state[x,y]) {
						board_state = new_state;
						return true;
					}
				}
			}
			return false;
		}

		private bool shift_rows_left () {
			int [,] new_state = new int[4,4];
			for (int y = 0; y < 4; y++) {
				for (int x = 0; x < 4; x++) {
					new_state[x,y] = board_state[x,y];
				}
			}
			for(int r = 0; r < 4; r++) {
				// Pull the next non-empty tile to current element
				for (int i = 0; i < 4 - 1; i++) {
					int c = i;
					while (new_state[c,r] == 0 && c < new_state.length[0] - 1) {
						c++;
					}
					if (c > i) {
						new_state[i,r] = new_state[c,r];
						new_state[c,r] = 0;
					}
				}
				// Combine Adjacent Elements that are the same
				for (int i = 0; i < new_state.length[0] - 1; i++) {
					if (new_state[i,r] == new_state[i+1,r]) {
						new_state[i,r] = 2*new_state[i,r];
						new_state[i+1,r] = 0;
					}
				}
				// Pull the next non-empty tile to current element
				for (int i = 0; i < 4 - 1; i++) {
					int c = i;
					while (new_state[c,r] == 0 && c < new_state.length[0] - 1) {
						c++;
					}
					if (c > i) {
						new_state[i,r] = new_state[c,r];
						new_state[c,r] = 0;
					}
				}
			}
			for (int y = 0; y < 4; y++) {
				for (int x = 0; x < 4; x++) {
					if (new_state[x,y] != board_state[x,y]) {
						board_state = new_state;
						return true;
					}
				}
			}
			return false;
		}

		private bool shift_rows_right () {
			int [,] new_state = new int[4,4];
			for (int y = 0; y < 4; y++) {
				for (int x = 0; x < 4; x++) {
					new_state[x,y] = board_state[x,y];
				}
			}
			for(int r = 0; r < 4; r++) {
				// Pull the next non-empty tile to current element
				for (int i = 3; i > 0; i--) {
					int c = i;
					while (new_state[c,r] == 0 && c > 0) {
						c--;
					}
					if (c < i) {
						new_state[i,r] = new_state[c,r];
						new_state[c,r] = 0;
					}
				}
				// Combine Adjacent Elements that are the same
				for (int i = 3; i > 0; i--) {
					if (new_state[i,r] == new_state[i-1,r]) {
						new_state[i,r] = 2*new_state[i,r];
						new_state[i-1,r] = 0;
					}
				}
				// Pull the next non-empty tile to current element
				for (int i = 3; i > 0; i--) {
					int c = i;
					while (new_state[c,r] == 0 && c > 0) {
						c--;
					}
					if (c < i) {
						new_state[i,r] = new_state[c,r];
						new_state[c,r] = 0;
					}
				}
			}
			for (int y = 0; y < 4; y++) {
				for (int x = 0; x < 4; x++) {
					if (new_state[x,y] != board_state[x,y]) {
						board_state = new_state;
						return true;
					}
				}
			}
			return false;
		}
	}
}
