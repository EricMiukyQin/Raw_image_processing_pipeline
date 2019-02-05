function value = metadata_value(metadata, key)
  idx = find(strcmp(metadata{1}, key));
  if(numel(idx) < 1)
    error(sprintf('No metadata with key %s', key));
  elseif(numel(idx) > 1)
    warning(sprintf('Found %d instances of key "%s", using first one', numel(idx), key));
    value = metadata{2}{idx(1)};
  else
    value = metadata{2}{idx};
  end
end