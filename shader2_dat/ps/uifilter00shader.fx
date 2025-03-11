float4 g_Color : register(c64);
float4 g_ColorLimit : register(c65);
sampler g_Sampler0 : register(s13);

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
