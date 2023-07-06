float4 g_BasePos;

float4 main(float3 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float r1;
	r0.xyz = -g_BasePos.xyz + texcoord.xyz;
	r0.x = dot(r0.xyz, r0.xyz);
	r0.x = 1 / sqrt(r0.x);
	r0.x = 1 / r0.x;
	r1.x = 0.6;
	r0 = g_BasePos.w * -r1.x + r0.x;
	clip(r0);
	o = 1;

	return o;
}
