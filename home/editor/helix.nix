{ lib, pkgs, ... }:

{
  programs.helix = {
    enable = true;

    settings = {
      theme = "darcula";
      editor = {
        rulers = [
          80
          120
        ];
        # cursorline = true;
        bufferline = "multiple";
        line-number = "relative";
        color-modes = true;
        end-of-line-diagnostics = "hint";

        cursor-shape.insert = "bar";

        file-picker.hidden = false;

        indent-guides.render = true;

        lsp.display-inlay-hints = true;

        inline-diagnostics = {
          cursor-line = "hint";
          other-lines = "hint";
        };
      };
      keys.normal = {
        esc = [
          "collapse_selection"
          "keep_primary_selection"
        ];
        "A-j" = [
          "search_selection"
          "extend_search_next"
        ];
        "A-h" = [ ":toggle lsp.display-inlay-hints" ];
      };
    };

    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = lib.getExe pkgs.nixfmt;
      }
    ];
  };
}
