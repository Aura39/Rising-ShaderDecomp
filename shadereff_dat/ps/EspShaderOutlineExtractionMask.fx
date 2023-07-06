float4 g_BlendColor;
float4 g_MatrialColor;
float4 g_OutLineRate;
sampler g_Sampler0;
sampler g_Sampler2;
float4 g_TargetOffSet;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0.x = 1 / i.texcoord1.w;
	r0.xy = r0.xx * i.texcoord1.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.zw = r0.xy + g_TargetOffSet.xy;
	r1 = tex2D(g_Sampler0, r0);
	r0 = tex2D(g_Sampler0, r0.zwzw);
	r0.y = r1.x * g_OutLineRate.x;
	if (g_OutLineRate.z < r0.y) {
		r1 = tex2D(g_Sampler2, i.texcoord);
		o.w = r1.w * g_BlendColor.w;
		o.xyz = g_BlendColor.xyz;
	} else {
		r0.x = r0.x * g_OutLineRate.x;
		r0.x = -abs(r0.x) + abs(r0.y);
		if (g_OutLineRate.y < abs(r0.x)) {
			r0 = tex2D(g_Sampler2, i.texcoord);
			o.w = r0.w * g_MatrialColor.w;
			o.xyz = g_MatrialColor.xyz;
		} else {
			r0 = tex2D(g_Sampler2, i.texcoord);
			o.w = r0.w * g_BlendColor.w;
			o.xyz = g_BlendColor.xyz;
		}
	}

	return o;
}
