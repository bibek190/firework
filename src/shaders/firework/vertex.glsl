uniform float uSize;
uniform vec2 uResolution;
uniform float uProgress;

attribute float aSize;

float remap(float value, float originMin, float originMax, float destinationMin, float destinationMax)
{
    return destinationMin + (value - originMin) * (destinationMax - destinationMin) / (originMax - originMin);
}

void main(){

    vec3 newPosition = position;

    // Exploding
    float explodingProgress = remap(uProgress,0.0,0.1,0.0,1.0);
    newPosition *=explodingProgress;

//final position 
    vec4 modelPosition = modelMatrix * vec4(newPosition,1.0);
    vec4 viewPosition = viewMatrix * modelPosition;
    vec4 projectedPosition = projectionMatrix * viewPosition;
    gl_Position = projectedPosition;
// final size
gl_PointSize = uSize * uResolution.y * aSize;
gl_PointSize *= 1.0 / -viewPosition.z;
}