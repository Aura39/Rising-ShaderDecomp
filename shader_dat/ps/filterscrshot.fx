sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	r0 = tex2D(g_Sampler1, texcoord);
	o.w = dot(r0.xyz, 0.298912);
	r0 = tex2D(g_Sampler0, texcoord);
	o.xyz = r0.xyz;

	return o;
}
