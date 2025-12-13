const osmTagKey = Symbol("osmTag");
const osmSourceKey = Symbol("osmSource");

export function $osmTag(context, target, ...tagNames) {
  const tags = tagNames[0];
  let values = [];
  if (tags.kind === "String") {
      values.push(tags.value);
  } else if (tags.kind === "Tuple") {
      for (const v of tags.values) {
          if (v.kind === "String") {
              values.push(v.value);
          }
      }
  }
  context.program.stateMap(osmTagKey).set(target, values);
}

export function getOsmTags(program, target) {
  return program.stateMap(osmTagKey).get(target);
}

export function $osmSource(context, target, ...sources) {
  const sourceArgs = sources[0];
  let values = [];
  if (sourceArgs.kind === "String") {
      values.push(sourceArgs.value);
  } else if (sourceArgs.kind === "Tuple") {
      for (const v of sourceArgs.values) {
          if (v.kind === "String") {
              values.push(v.value);
          }
      }
  }
  context.program.stateMap(osmSourceKey).set(target, values);
}

export function getOsmSources(program, target) {
  return program.stateMap(osmSourceKey).get(target);
}
