const osmTagKey = Symbol("osmTag");

export function $osmTag(context, target, tagName) {
  context.program.stateMap(osmTagKey).set(target, tagName.value);
}

export function getOsmTag(program, target) {
  return program.stateMap(osmTagKey).get(target);
}
