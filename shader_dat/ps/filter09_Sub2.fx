sampler g_SamplerTexture : register(s0);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	r0 = tex2D(g_SamplerTexture, texcoord);
	o.w = dot(r0.xyz, 0.299);
	o.xyz = r0.xyz;

	return o;
}
