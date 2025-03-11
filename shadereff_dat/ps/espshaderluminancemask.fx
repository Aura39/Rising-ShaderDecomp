float4 g_MatrialColor : register(c184);
float4 g_Rate : register(c185);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = tex2D(g_Sampler0, texcoord);
	r1 = r0.w + -0.0001;
	clip(r1);
	r0.w = dot(r0.xyz, 0.298912);
	r0.w = r0.w * g_Rate.x;
	r1.xyz = r0.xyz * g_MatrialColor.xyz;
	r0.xyz = r0.xyz * -g_MatrialColor.xyz + r0.xyz;
	o.xyz = r0.www * r0.xyz + r1.xyz;
	r0 = tex2D(g_Sampler1, texcoord);
	o.w = r0.w * g_MatrialColor.w;

	return o;
}
