sampler ColorTableTexture : register(s1);
float4 g_MatrialColor : register(c184);
float4 g_Saido : register(c185);
sampler g_SamplerTexture : register(s0);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.y = 0;
	r1 = tex2D(g_SamplerTexture, texcoord);
	r0.x = dot(r1.xyz, 0.298912);
	r2 = tex2D(ColorTableTexture, r0);
	r0.x = 1 / r0.x;
	r0.yzw = r1.xyz * r2.xxx;
	r1.xyz = r0.yzw * r0.xxx + -r2.xxx;
	r0.xyz = r0.xxx * r0.yzw;
	r0.xyz = r1.xyz * g_Saido.xyz + r0.xyz;
	r0.w = 1;
	o = r0 * g_MatrialColor;

	return o;
}
