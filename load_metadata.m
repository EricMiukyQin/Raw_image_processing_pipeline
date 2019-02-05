function metadata = load_metadata(data_path)
  f = fopen(data_path);
  metadata = (textscan(f, '%q%q', 'delimiter', ','));
  fclose(f);
end