sampler ColorTableTexture : register(s1);
float4 g_AddColor : register(c186);
float4 g_MatrialColor : register(c184);
float4 g_Saido : register(c185);
sampler g_SamplerTexture : register(s0);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	r0 = tex2D(g_SamplerTexture, texcoord);
	r1.xy = r0.zx * float2(1, 0);
	r1 = tex2D(ColorTableTexture, r1);
	r1.z = r1.x;
	r2 = r0.xxyx * float4(1, 0, 1, 0);
	r3 = tex2D(ColorTableTexture, r2);
	r2 = tex2D(ColorTableTexture, r2.zwzw);
	r1.y = r2.x;
	r1.x = r3.x;
	r0.x = dot(r1.xyz, 0.298912);
	r0.y = r0.w * g_Saido.w + r0.x;
	r0.xzw = -r0.xxx + r1.xyz;
	r0.xzw = r0.xzw * g_Saido.xyz + r1.xyz;
	o.w = r0.y + -g_MatrialColor.w;
	r1.x = 1;
	r0.y = texcoord.y * -g_AddColor.w + r1.x;
	r1.xyz = r0.yyy * g_AddColor.xyz;
	o.xyz = r0.xzw * g_MatrialColor.xyz + r1.xyz;

	return o;
}
