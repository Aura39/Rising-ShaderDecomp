float4 g_Color;
float4 g_ColorLimit;
sampler g_Sampler0;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = tex2D(g_Sampler0, texcoord);
	r1.xyz = min(g_ColorLimit.xyz, r0.xyz);
	r1.w = 1;
	o = r1 * g_Color;

	return o;
}
