sampler g_Sampler;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	o = tex2D(g_Sampler, texcoord);

	return o;
}
