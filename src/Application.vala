namespace FourK{
	public class Application : Gtk.Application {
		public MainWindow app_window;

		private Controllers.Game game_controller;
		private Models.Game game_model;
		private Views.GameView game_view;

		private Gtk.EventControllerKey key_controller;

		public Application () {
			Object (
				application_id: "com.github.fourkgamedevs.fourk",
				flags: ApplicationFlags.FLAGS_NONE
			);
		}

		protected override void activate () {
			setup_color_preference ();
			setup_custom_resources ();
			setup_custom_css ();

			if (get_windows().length() > 0) {
				app_window.present();
				return;
			}

			app_window = new MainWindow (this);

			key_controller = new Gtk.EventControllerKey (app_window);

			game_model = new Models.Game ();
			game_view = new Views.GameView (app_window);

			game_controller = new Controllers.Game (game_model, game_view, key_controller);

			app_window.add_view (game_view);
			app_window.show_all ();
		}

		private void setup_color_preference () {
			var granite_settings = Granite.Settings.get_default ();
			var gtk_settings = Gtk.Settings.get_default ();
			gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;

			granite_settings.notify["prefers_color_scheme"].connect (() => {
				gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;
			});
		}

		private void setup_custom_resources () {
			Gtk.IconTheme.get_default ().add_resource_path("/com/github/fourkgamedevs/fourk");
		}

		private void setup_custom_css () {
			var css_provider = new Gtk.CssProvider ();
			try {
				css_provider.load_from_resource("/com/github/fourkgamedevs/fourk/Tile.css");
			} catch (GLib.Error e) {
				warning ("Could not get css provider");
			}

			Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
		}

		public static int main (string[] args) {
			return new Application ().run (args);
		}
	}

	public enum Directions {
		UP,
		DOWN,
		LEFT,
		RIGHT
	}
}
