sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);
sampler g_Sampler2 : register(s2);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = tex2D(g_Sampler0, texcoord);
	r1 = tex2D(g_Sampler1, texcoord);
	r0 = r0 + r1;
	r1 = tex2D(g_Sampler2, texcoord);
	r0 = r0 + r1;
	o = r0 * 0.33333334;

	return o;
}
