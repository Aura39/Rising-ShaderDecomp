sampler g_Sampler : register(s0);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	o = tex2D(g_Sampler, texcoord);

	return o;
}
