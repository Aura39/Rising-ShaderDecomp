sampler g_Sampler : register(s0);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r1;
	float4 r0;
	r1 = tex2D(g_Sampler, texcoord);
	r0 = r1.z + -0.01;
	o = r1;
	clip(r0);

	return o;
}
