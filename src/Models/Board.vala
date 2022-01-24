namespace FourK.Models {
	internal class Board {
		private int[,] board_state;
		private bool[,] tile_merged_states;
		private bool[] valid_move_state;

		public Board () {
			tile_merged_states = new bool[4,4];
			board_state = new int[4,4];
			valid_move_state = new bool[4];
			clear_board ();
		}

		public void clear_board () {
			for (int r = 0; r < 4; r++) {
				for (int c = 0; c < 4; c++) {
					board_state[c,r] = 0;
				}
			}
			reset_tile_merge_states ();
			reset_valid_moves ();
		}

		public int[,] get_state () {
			return board_state;
		}

		public bool[,] get_merged_tiles_state() {
			return tile_merged_states;
		}

		public bool[] get_valid_moves () {
			return valid_move_state;
		}

		public int get_largest_tile_value () {
			int result = 0;
			for (int r = 0; r < 4; r++) {
				for (int c = 0; c < 4; c++) {
					if (board_state[c,r] > result) {
						result = board_state[c,r];
					}
				}
			}
			return result;
		}

		public void spawn_tile () {
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
			update_valid_moves ();
		}

		public void spawn_first_tile () {
			int val = 2;
			int index_x = GLib.Random.int_range (0,4);
			int index_y = GLib.Random.int_range (0,4);
			board_state[index_x,index_y] = val;
			update_valid_moves ();
		}

		public void shift_cols_up () {
			for (int c = 0; c < 4; c++) {
				for (int r = 0; r < 4; r++) {
					shift_tile(c, r, FourK.Directions.UP);
				}
			}
			update_valid_moves ();
		}

		public void shift_cols_down () {
			for (int c = 0; c < 4; c++) {
				for (int r = 3; r > -1; r--) {
					shift_tile(c, r, FourK.Directions.DOWN);
				}
			}
			update_valid_moves ();
		}

		public void shift_rows_right () {
			for (int r = 0; r < 4; r++) {
				for (int c = 3; c > -1; c--) {
					shift_tile(c, r, FourK.Directions.RIGHT);
				}
			}
			update_valid_moves ();
		}

		public void shift_rows_left () {
			for (int r = 0; r < 4; r++) {
				for (int c = 0; c < 4; c++) {
					shift_tile(c, r, FourK.Directions.LEFT);
				}
			}
			update_valid_moves ();
		}

		public void reset_tile_merge_states () {
			for (int r = 0; r < 4; r++) {
				for (int c = 0; c < 4; c++) {
					tile_merged_states[c,r] = false;
				}
			}
		}
		private void reset_valid_moves (){
			for (int i = 0; i < 4; i++) {
				valid_move_state[i] = true;
			}
		}

		private void update_valid_moves () {
			for (int i = 0; i < 4; i++) {
				valid_move_state[i] = false;
			}

			for (int r = 0; r < 4; r++) {
				for (int c = 0; c < 4; c++) {
					if (is_tile_mergable(c,r,FourK.Directions.RIGHT) || is_tile_movable(c,r,FourK.Directions.RIGHT)) {
						valid_move_state[FourK.Directions.RIGHT] = true;
					}
					if (is_tile_mergable(c,r,FourK.Directions.LEFT) || is_tile_movable(c,r,FourK.Directions.LEFT)) {
						valid_move_state[FourK.Directions.LEFT] = true;
					}
					if (is_tile_mergable(c,r,FourK.Directions.UP) || is_tile_movable(c,r,FourK.Directions.UP)) {
						valid_move_state[FourK.Directions.UP] = true;
					}
					if (is_tile_mergable(c,r,FourK.Directions.DOWN) || is_tile_movable(c,r,FourK.Directions.DOWN)) {
						valid_move_state[FourK.Directions.DOWN] = true;
					}
				}
			}
			//print_board ();
		}

		private void shift_tile (int index_c, int index_r, FourK.Directions direction) {
			int[] new_position = find_furthest_free_space (index_c, index_r, direction);

			if (new_position[0] != index_c || new_position[1] != index_r) {
				board_state[new_position[0], new_position[1]] = board_state[index_c, index_r];
				board_state[index_c, index_r] = 0;
			}

			bool is_mergable = is_tile_mergable (new_position[0], new_position[1], direction);

			if (is_mergable) {
				merge_tile (new_position[0], new_position[1], direction);
			}
		}

		private bool is_tile_mergable (int index_c, int index_r, FourK.Directions direction) {
			if (board_state[index_c,index_r] == 0) {
				return false;
			}
			switch (direction) {
				case FourK.Directions.RIGHT:
					if (index_c != 3 && board_state[index_c, index_r] == board_state[index_c+1, index_r] && tile_merged_states[index_c+1, index_r] == false ) {
						return true;
					}
					break;
				case FourK.Directions.LEFT:
					if (index_c != 0 && board_state[index_c, index_r] == board_state[index_c-1, index_r] && tile_merged_states[index_c-1, index_r] == false ) {
						return true;
					}
					break;
				case FourK.Directions.DOWN:
					if (index_r != 3 && board_state[index_c, index_r] == board_state[index_c, index_r+1] && tile_merged_states[index_c, index_r+1] == false ) {
						return true;
					}
					break;
				case FourK.Directions.UP:
					if (index_r != 0 && board_state[index_c, index_r] == board_state[index_c, index_r-1] && tile_merged_states[index_c, index_r-1] == false ) {
						return true;
					}
					break;
			}
			return false;
		}

		private bool is_tile_movable (int index_c, int index_r, FourK.Directions direction) {
			if (board_state[index_c,index_r] == 0) {
				return false;
			}

			int[] new_position = find_furthest_free_space (index_c, index_r, direction);

			switch (direction) {
				case FourK.Directions.RIGHT:
					if (index_c != 3) {
						if (new_position[0] != index_c || new_position[1] != index_r) {
							return true;
						}
					}
					break;
				case FourK.Directions.LEFT:
					if (index_c != 0) {
						if (new_position[0] != index_c || new_position[1] != index_r) {
							return true;
						}
					}
					break;
				case FourK.Directions.DOWN:
					if (index_r != 3) {
						if (new_position[0] != index_c || new_position[1] != index_r) {
							return true;
						}
					}
					break;
				case FourK.Directions.UP:
					if (index_r != 0) {
						if (new_position[0] != index_c || new_position[1] != index_r) {
							return true;
						}
					}
					break;
			}
			return false;
		}

		private void merge_tile (int index_c, int index_r, FourK.Directions direction) {
			switch (direction) {
				case FourK.Directions.RIGHT:
					if (index_c != 3) {
						tile_merged_states[index_c + 1, index_r] = true;
						board_state[index_c + 1, index_r] = board_state[index_c, index_r] * 2;
						board_state[index_c, index_r] = 0;
					}
					break;
				case FourK.Directions.LEFT:
					if (index_c != 0) {
						tile_merged_states[index_c - 1, index_r] = true;
						board_state[index_c - 1, index_r] = board_state[index_c, index_r] * 2;
						board_state[index_c, index_r] = 0;
					}
					break;
				case FourK.Directions.DOWN:
					if (index_r != 3) {
						tile_merged_states[index_c, index_r + 1] = true;
						board_state[index_c, index_r + 1] = board_state[index_c, index_r] * 2;
						board_state[index_c, index_r] = 0;
					}
					break;
				case FourK.Directions.UP:
					if (index_r != 0) {
						tile_merged_states[index_c, index_r - 1] = true;
						board_state[index_c, index_r - 1] = board_state[index_c, index_r] * 2;
						board_state[index_c, index_r] = 0;
					}
					break;
			}
		}

		private int[] find_furthest_free_space (int index_c, int index_r, FourK.Directions direction) {
			int[] position = new int[2];
			position[0] = index_c;
			position[1] = index_r;

			switch (direction) {
				case FourK.Directions.RIGHT:
					for (int c = position[0]; c < 4; c++) {
						if (board_state[c, position[1]] == 0) {
							position[0] = c;
						}
					}
					break;
				case FourK.Directions.LEFT:
					for (int c = position[0]; c > -1; c--) {
						if (board_state[c, position[1]] == 0) {
							position[0] = c;
						}
					}
					break;
				case FourK.Directions.DOWN:
					for (int r = position[1]; r < 4; r++) {
						if (board_state[position[0], r] == 0) {
							position[1] = r;
						}
					}
					break;
				case FourK.Directions.UP:
					for (int r = position[1]; r > -1; r--) {
						if (board_state[position[0], r] == 0) {
							position[1] = r;
						}
					}
					break;
			}
			return position;
		}
	}
}
