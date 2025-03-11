float4 g_MatrialColor : register(c184);
sampler g_SamplerTexture : register(s0);
float4 g_pow : register(c185);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	r0 = tex2D(g_SamplerTexture, texcoord);
	r1.xy = float2(0.0055555557, 0.0027777778);
	r2.xy = g_pow.xx * r1.xy + texcoord.yy;
	r2.z = texcoord.x;
	r3 = tex2D(g_SamplerTexture, r2.zxzw);
	r2 = tex2D(g_SamplerTexture, r2.zyzw);
	r0 = r3 * 0.6 + r0;
	r0.xyz = r2.xyz * 0.8 + r0.xyz;
	r1.xy = g_pow.xx * -r1.xy + texcoord.yy;
	r1.z = texcoord.x;
	r2 = tex2D(g_SamplerTexture, r1.zxzw);
	r1 = tex2D(g_SamplerTexture, r1.zyzw);
	r0 = r2.wxyz * 0.6 + r0.wxyz;
	r0.yzw = r1.xyz * 0.8 + r0.yzw;
	o.w = r0.x * g_MatrialColor.w;
	r0.xyz = r0.yzw * g_MatrialColor.xyz;
	o.xyz = r0.xyz * 0.2631579;

	return o;
}
