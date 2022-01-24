namespace FourK{
	public class Application : Gtk.Application {
		public MainWindow app_window;

		public Application () {
			Object (
				application_id: "com.github.keilith-l.fourk",
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
			Gtk.IconTheme.get_default ().add_resource_path("/com/github/keilith-l/fourk");
		}

		private void setup_custom_css () {
			var css_provider = new Gtk.CssProvider ();
			try {
				css_provider.load_from_path("../src/Widgets/Tile.css");
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
