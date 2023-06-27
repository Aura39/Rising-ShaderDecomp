float2 influence;

float4 main(float3 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float2 r0;
	r0.x = 0.004 * texcoord.z;
	r0.x = -r0.x + 1;
	o.xy = r0.xx * influence.xy;
	r0.y = 1;
	r0.y = r0.y + -influence.x;
	r0.y = r0.y + -influence.y;
	o.z = r0.y * r0.x;
	o.w = 1;

	return o;
}
