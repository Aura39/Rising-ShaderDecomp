float4 g_GlareColor1 : register(c185);
float4 g_GlareColor2 : register(c186);
float4 g_MatrialColor : register(c184);
sampler g_SamplerTexture : register(s0);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = tex2D(g_SamplerTexture, texcoord);
	r1 = float4(0.0109375, 0, 0.0046875, 0) + texcoord.xyxy;
	r2 = tex2D(g_SamplerTexture, r1);
	r1 = tex2D(g_SamplerTexture, r1.zwzw);
	r0 = r2 * 0.45 + r0;
	r0 = r1 * 0.8 + r0;
	r1 = float4(-0.0109375, 0, -0.0046875, 0) + texcoord.xyxy;
	r2 = tex2D(g_SamplerTexture, r1);
	r1 = tex2D(g_SamplerTexture, r1.zwzw);
	r0 = r2 * 0.45 + r0;
	r0 = r1 * 0.8 + r0;
	r0 = r0 * 0.2857143;
	r1.xyz = g_GlareColor1.xyz;
	r1.xyz = -r1.xyz + g_GlareColor2.xyz;
	r1.xyz = r0.www * r1.xyz + g_GlareColor1.xyz;
	r0.xyz = r0.xyz * r1.xyz;
	o = r0 * g_MatrialColor;

	return o;
}
