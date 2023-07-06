float4 g_MatrialColor;
sampler g_Sampler0;
sampler g_Sampler1;
sampler g_Sampler2;
sampler g_Sampler3;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = tex2D(g_Sampler3, texcoord);
	r1 = tex2D(g_Sampler2, texcoord);
	r1.x = r1.w + -0.5;
	r1.xy = r1.xx * float2(1.596, 0.813);
	r2 = tex2D(g_Sampler1, texcoord);
	r1.z = r2.w + -0.5;
	r1.y = r1.z * -0.392 + -r1.y;
	r1.z = r1.z * 2.017;
	r2 = tex2D(g_Sampler0, texcoord);
	r1.w = r2.w + -0.0625;
	r0.y = r1.w * 1.164 + r1.y;
	r0.x = r1.w * 1.164 + r1.x;
	r0.z = r1.w * 1.164 + r1.z;
	o = r0 * g_MatrialColor;

	return o;
}
